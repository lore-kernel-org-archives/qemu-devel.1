Received: from eggs.gnu.org ([2001:4830:134:3::10]:45065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYvPp-0008GK-1P
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYvPl-00068X-Vr
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:34:29 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYvPl-00067g-RL
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:34:25 -0400
Received: by mail-qk0-x243.google.com with SMTP id t79-v6so5135262qke.4
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 08:34:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180628164643.9668-1-f4bug@amsat.org> <871scpvetm.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3e8c208c-2157-a6f0-3187-8929094012f6@amsat.org>
Date: Fri, 29 Jun 2018 12:34:21 -0300
MIME-Version: 1.0
In-Reply-To: <871scpvetm.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/8] Docker improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, Thomas Huth <huth@tuxfamily.org>, Paolo Bonzini <pbonzini@redhat.com>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org

On 06/29/2018 11:37 AM, Alex Bennée wrote:
> I've queued the following in my tree.
> 
>>   docker: ubuntu: Update the package list before installing new ones
>>   docker: ubuntu: Use SDL2
>>   docker: Clean the MXE base image
>>   docker: Do not run tests in 'intermediate' images

Thanks!
