Received: from eggs.gnu.org ([2001:4830:134:3::10]:47631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTaoy-0007t3-OD
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTaov-0008Gq-Kq
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:34:24 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:46966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTaov-0008Fr-C4
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:34:21 -0400
Received: by mail-pf0-x241.google.com with SMTP id q1-v6so3909325pff.13
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 15:34:21 -0700 (PDT)
References: <20180614105323.22524-1-mark.cave-ayland@ilande.co.uk>
	<20180614105323.22524-2-mark.cave-ayland@ilande.co.uk>
	<bc94cc82-5894-5c3b-2f86-b84d6920fb1a@linaro.org>
	<3ab4d967-a930-4d61-1442-431114f9f1ea@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2334e127-211a-f07f-34ce-bc09f6a631f4@linaro.org>
Date: Thu, 14 Jun 2018 12:34:15 -1000
MIME-Version: 1.0
In-Reply-To: <3ab4d967-a930-4d61-1442-431114f9f1ea@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFCv2 PATCH 1/1] SPARC64: add icount support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com, cota@braap.org

On 06/14/2018 12:09 PM, Mark Cave-Ayland wrote:
> I still see the "WARNING: Time of Day clock error" messages on the console when
> booting Milax with icount enabled, although I'm inclined to merge this if
> you're happy with the patch as it is a definite improvement.

Yeah, let's fix whatever that is separately.


r~
