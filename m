Received: from eggs.gnu.org ([2001:4830:134:3::10]:39702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faonT-00013f-EC
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faonQ-0008Rf-Bu
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:54:43 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:39258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1faonP-0008Qm-Ta
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 16:54:40 -0400
Received: by mail-pf0-x231.google.com with SMTP id s21-v6so3460392pfm.6
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 13:54:39 -0700 (PDT)
References: <20180702151023.24532-1-shorne@gmail.com>
	<20180702151023.24532-23-shorne@gmail.com>
	<feef2195-8fd8-f9e1-da85-f3286a9e2b1d@amsat.org>
	<CAAfxs77LqYG2gGT3Y0xs=SYMdQ9GoO0hymdwF-UGZcjXyrQUMg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <43d6bc18-440a-31e9-f055-8d0b14cbc74e@linaro.org>
Date: Wed, 4 Jul 2018 13:54:35 -0700
MIME-Version: 1.0
In-Reply-To: <CAAfxs77LqYG2gGT3Y0xs=SYMdQ9GoO0hymdwF-UGZcjXyrQUMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 22/25] linux-user: Implement signals for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 07/03/2018 04:51 PM, Stafford Horne wrote:
> Richard, how do you usually remove these before your pr?  I suppose you have
> some kind of script?

No, I just edit the things by hand.


r~
