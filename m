Received: from eggs.gnu.org ([2001:4830:134:3::10]:48044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1et8Vx-0008Og-Jm
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1et8Vs-00068g-0K
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:04:05 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1et8Vr-00068M-QD
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:03:59 -0500
Received: by mail-wr0-x234.google.com with SMTP id l43so20099541wrc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 01:03:59 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1519984765-15748-1-git-send-email-konrad@adacore.com>
	<8a0c9302-3c3a-6d2f-064c-231adc126dbd@twiddle.net>
	<7c87cbfc-242a-b875-35b1-4ef1a4763808@ilande.co.uk>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a6be7de8-53ed-f429-236a-20d0110e5f52@twiddle.net>
Date: Tue, 6 Mar 2018 09:03:50 +0000
MIME-Version: 1.0
In-Reply-To: <7c87cbfc-242a-b875-35b1-4ef1a4763808@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sparc: fix leon3 casa instruction when MMU
 is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, KONRAD Frederic <konrad@adacore.com>, qemu-devel@nongnu.org
Cc: frederic.konrad@adacore.com

On 03/05/2018 09:56 PM, Mark Cave-Ayland wrote:
> Thanks for reviewing the patch Richard. Do you want me to take this one via my
> qemu-sparc branch?

Yes, please.

r~
