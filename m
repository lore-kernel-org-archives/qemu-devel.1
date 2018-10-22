Received: from eggs.gnu.org ([2001:4830:134:3::10]:46450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEjQs-0006xI-HD
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEjQp-0006IY-9N
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:16:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEjQo-0006H9-58
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:16:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so10278550wmd.0
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 16:16:17 -0700 (PDT)
References: <cover.1540134918.git.noring@nocrew.org>
	<BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181022172343.GB2331@sx9>
	<alpine.LFD.2.21.1810221901170.19280@eddie.linux-mips.org>
	<alpine.LFD.2.21.1810221932480.19280@eddie.linux-mips.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b784211e-2c26-53ff-a271-e7cd7ccf6892@redhat.com>
Date: Tue, 23 Oct 2018 01:16:15 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1810221932480.19280@eddie.linux-mips.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maciej W. Rozycki" <macro@linux-mips.org>, Fredrik Noring <noring@nocrew.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 22/10/18 20:40, Maciej W. Rozycki wrote:
> On Mon, 22 Oct 2018, Maciej W. Rozycki wrote:
> 
>> Hi Maciej,
> 
>   What an odd copy & paste thinko!  I can't believe I addressed myself in
> the opening of my e-mail. :)

Haha when I saw your mail I thought "weird, there is another Maciej 
involved in this MIPS specific thread!?"
