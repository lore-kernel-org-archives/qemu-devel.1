Received: from eggs.gnu.org ([2001:4830:134:3::10]:44061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dL0dj-0007jI-Is
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dL0dg-0005Bh-CF
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:14:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dL0dg-00059v-5D
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:14:44 -0400
Received: by mail-wr0-f196.google.com with SMTP id v104so35917870wrb.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 22:14:42 -0700 (PDT)
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<20170608184944.19406-10-mrolnik@gmail.com>
	<2dba69fb-2894-5f8b-bc61-abfa97873dcf@tuxfamily.org>
	<CAK4993hf9TSqzNAs6-c-TvD2zX7rQDh4X39AyRofehfN_nsRYQ@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <9ac47825-aeb0-3dc8-3e47-7bbcad19f730@tuxfamily.org>
Date: Wed, 14 Jun 2017 07:14:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAK4993hf9TSqzNAs6-c-TvD2zX7rQDh4X39AyRofehfN_nsRYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v19 09/13] target-avr: adding
 instruction decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Rolnik <mrolnik@gmail.com>, Thomas Huth <huth@tuxfamily.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Anichang <anichang@protonmail.ch>

On 13.06.2017 22:29, Michael Rolnik wrote:
> this is generated code. 

Hmm, then it should likely not be included in a patch, but generated
during built-time instead, I guess?

 Thomas
