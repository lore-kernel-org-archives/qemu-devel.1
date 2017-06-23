Received: from eggs.gnu.org ([2001:4830:134:3::10]:45150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOOpr-0001Ct-8l
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOOpn-0003Rv-95
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:41:19 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:33938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dOOpn-0003Rl-3f
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 09:41:15 -0400
Received: by mail-qk0-x229.google.com with SMTP id d78so2140710qkb.1
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 06:41:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-14-f4bug@amsat.org> <877f04tj8a.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <15f519c4-0a85-3fdb-875c-aba681def577@amsat.org>
Date: Fri, 23 Jun 2017 10:41:11 -0300
MIME-Version: 1.0
In-Reply-To: <877f04tj8a.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/21] travis: improve ccache use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 06/22/2017 07:22 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Can you expand the commit message to breifly explain what all these
> extra settings change. What is CCACHE_SLOPINESS and ccache -s doing?

I'm pretty sure I wrote something here ... probably lost using git Fu :(
