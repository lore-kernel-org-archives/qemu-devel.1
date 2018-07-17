Received: from eggs.gnu.org ([2001:4830:134:3::10]:51374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRgN-0002zK-Vk
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRgK-0004G6-Qk
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:14:31 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffRgK-0004FZ-KE
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:14:28 -0400
Received: by mail-qt0-x241.google.com with SMTP id t5-v6so1177148qtn.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:14:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-14-alex.bennee@linaro.org>
	<6af06a44-1ea6-0b5e-087a-4bef58ea1464@amsat.org>
Message-ID: <89e84582-3aa5-61e2-e75e-b8660cb68ee5@amsat.org>
Date: Tue, 17 Jul 2018 12:14:22 -0300
MIME-Version: 1.0
In-Reply-To: <6af06a44-1ea6-0b5e-087a-4bef58ea1464@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 13/16] docker: add --hint to
 docker.py check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 07/17/2018 12:24 AM, Philippe Mathieu-Daudé wrote:
> On 07/13/2018 09:17 AM, Alex Bennée wrote:
>> When a check fails we currently just report why we failed. This is not
>> totally helpful to people who want to boot-strap a new image. Add a
>> --hint option which we can pass down to give a bit more information.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
