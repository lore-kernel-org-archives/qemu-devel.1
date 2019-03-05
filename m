Received: from eggs.gnu.org ([209.51.188.92]:44871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1AkJ-0005IY-Md
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1AkI-00061s-Tr
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:08:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1AkI-00060x-NZ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:08:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so9621134wrx.2
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 06:08:38 -0800 (PST)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <1551733750-4902-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1551733750-4902-3-git-send-email-aleksandar.markovic@rt-rk.com>
	<8acd73e1-219f-b5f7-e001-6f6dd086171d@redhat.com>
	<BN6PR2201MB12512A365C6D47928700801CC6720@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<96d80f22-8f7b-950a-283d-2c814827cd82@redhat.com>
Message-ID: <bb8af505-4bfb-0488-7278-8dd5748ee0fd@redhat.com>
Date: Tue, 5 Mar 2019 15:08:36 +0100
MIME-Version: 1.0
In-Reply-To: <96d80f22-8f7b-950a-283d-2c814827cd82@redhat.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 02/14] disas: nanoMIPS: Add graphical
 description of pool organization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

On 3/5/19 3:07 PM, Philippe Mathieu-Daud¨¦ wrote:
> On 3/5/19 1:39 PM, Aleksandar Markovic wrote:
>>> From: Philippe Mathieu-Daud¨¦ <philmd@redhat.com>
>>> On 3/4/19 10:08 PM, Aleksandar Markovic wrote:
>>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>>
>>>> Add graphical description of nanoMIPS instruction pool organization.
>>>>
[...]
>> Yes, it does fit 80 characters limit. It was created manually. I stumbled
>> upon https://pythonhosted.org/asciitree/#ascii-trees the other day, but
>> never used it, you may find it useful.
> 
> I'm tempted add it to the decodetree script...

"I'm tempted [to] add it" ...
(I'm not suggesting you to add it)
