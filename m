Received: from eggs.gnu.org ([2001:4830:134:3::10]:36073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dKs8T-0002XA-5W
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dKs8O-00072k-7B
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:09:57 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dKs8O-00072f-12
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:09:52 -0400
Received: by mail-wr0-f196.google.com with SMTP id 77so3066701wrb.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 13:09:51 -0700 (PDT)
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<20170608184944.19406-2-mrolnik@gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <bcd25371-e16f-4fe5-6298-f273720cbaad@tuxfamily.org>
Date: Tue, 13 Jun 2017 22:09:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170608184944.19406-2-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v19 01/13] target-avr: AVR cores
 support is added.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, anichang@protonmail.ch

On 08.06.2017 20:49, Michael Rolnik wrote:
>     1. basic CPU structure
>     2. registers
>     3. no instructions
>     4. saving sreg, rampD, rampX, rampY, rampD, eind in HW representation
> 
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Message-Id: <1471522070-77598-2-git-send-email-mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Why is the final "Signed-off-by" by Richard, if the patch has apparently
been sent by you, Michael? Something is wrong here with the order...

 Thomas
