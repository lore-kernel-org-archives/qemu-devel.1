Received: from eggs.gnu.org ([2001:4830:134:3::10]:44831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciqur-0006bA-IS
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciquo-0001kF-Ds
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:10:45 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ciquo-0001jr-7x
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:10:42 -0500
Received: by mail-pf0-x242.google.com with SMTP id j5so1948825pfb.3
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 15:10:42 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170228120134.7921-1-ebischoff@suse.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <009b7efb-7e1f-5eaa-6861-9508eeef422d@twiddle.net>
Date: Wed, 1 Mar 2017 10:10:35 +1100
MIME-Version: 1.0
In-Reply-To: <20170228120134.7921-1-ebischoff@suse.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Adding support for LPD and LPDG
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Bischoff <ebischoff@suse.com>, Alexander Graf <agraf@suse.de>
Cc: Michal Marek <mmarek@suse.cz>, Miroslav Benes <mbenes@suse.cz>, QEmu developers <qemu-devel@nongnu.org>, Eric Bischoff <ebischoff@nerim.net>

On 02/28/2017 11:01 PM, Eric Bischoff wrote:
> From: Eric Bischoff <ebischoff@nerim.net>
>
> LPD = LOAD PAIR DISJOINT
> Fourth patch
> ---
>  target/s390x/insn-data.def |  4 ++-
>  target/s390x/translate.c   | 63 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 1 deletion(-)

Oh, I'm also missing a Signed-off-by.


r~
