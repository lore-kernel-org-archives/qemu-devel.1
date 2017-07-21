Received: from eggs.gnu.org ([2001:4830:134:3::10]:49258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYLTr-0004pu-9L
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 20:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYLTo-00089d-56
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 20:07:43 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:33972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dYLTo-00089H-0q
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 20:07:40 -0400
Received: by mail-qt0-x233.google.com with SMTP id 32so33183796qtv.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 17:07:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-43-git-send-email-cota@braap.org>
	<8f18a24d-01f8-7b57-33ef-f89939acd3c6@twiddle.net>
	<20170720205041.GA8754@flamenco>
	<b1ab270d-2812-a11b-a6c7-fda0b8d0b42e@twiddle.net>
	<20170720232318.GA5548@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <923185fe-8641-96f6-3fb1-7f6cd8f9d1f5@twiddle.net>
Date: Thu, 20 Jul 2017 14:07:34 -1000
MIME-Version: 1.0
In-Reply-To: <20170720232318.GA5548@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 42/43] tcg: introduce regions to split
 code_gen_buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/20/2017 01:23 PM, Emilio G. Cota wrote:
> That's a nice helper -- will do it this way.
> 
> For v4, should I send all patches again, or just the handful of patches
> that are changing from v3?

I don't mind if you just send the changed patches.
Just be sure to reference the tree in the cover letter.


r~
