Received: from eggs.gnu.org ([209.51.188.92]:60639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwAjk-0005Kw-Ub
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwAjf-0004pE-FJ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:07:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwAjf-0004oy-6y
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:07:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so11043154wrw.8
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 11:07:19 -0800 (PST)
References: <20190204202609.26956-1-philmd@redhat.com>
	<20190204202609.26956-7-philmd@redhat.com>
	<BN6PR2201MB1251A4E97F48E4ABBB007AD1C67C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b0917b43-689f-c824-0198-b578becd4dfe@redhat.com>
Date: Tue, 19 Feb 2019 20:07:16 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251A4E97F48E4ABBB007AD1C67C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] mips: Express dependencies of the
 Loongson 2E machine with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, Thomas Huth <thuth@redhat.com>

On 2/19/19 6:54 PM, Aleksandar Markovic wrote:
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Subject: [PATCH v2 6/6] mips: Express dependencies of the Loongson 2E machine with kconfig
>>
>> The Loongson 2E uses a Bonito64 system controller as North Bridge and a
>> VT82C686 chipset as South Bridge. The network card chipset is a RTL8139D.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
> 
> Hello, Philippe.
> 
> "Loongson 2E" is rather a name for an ISA, used also as a name for CPU that
> supports that ISA, while "Fulong 2E" (that uses Loongson 2E as a CPU) is the
> proper machine name that should be used in the title and commit message of
> this patch, IMHO.

You are right! thanks for noticing this :)

> 
> Aleksandar
> 
> 
