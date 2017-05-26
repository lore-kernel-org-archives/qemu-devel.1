Received: from eggs.gnu.org ([2001:4830:134:3::10]:49822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEFXl-0002hG-1s
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEFXk-0001xO-ED
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:44:41 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEFXk-0001vx-AO
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:44:40 -0400
Received: by mail-qk0-x244.google.com with SMTP id k74so1201031qke.2
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 06:44:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-5-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <35deebf0-438d-b491-0622-6522021420a8@twiddle.net>
Date: Fri, 26 May 2017 06:44:36 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-5-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/26] target/s390x: implement TEST
 ADDRESSING MODE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/25/2017 02:04 PM, Aurelien Jarno wrote:
> +    tcg_gen_movi_i32(cc_op, cc);
> +    set_cc_static(s);

gen_op_movi_cc


r~
