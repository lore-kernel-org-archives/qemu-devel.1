Received: from eggs.gnu.org ([2001:4830:134:3::10]:40230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnKg-0007ZJ-AK
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnKc-0004M0-Cs
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:01:34 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnKc-0004Lw-9J
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:01:30 -0400
Received: by mail-qt0-x243.google.com with SMTP id a46so13683823qte.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:01:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-5-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <697c9440-226b-cc9c-0803-5b073e112777@twiddle.net>
Date: Tue, 30 May 2017 13:01:25 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-5-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/29] target/s390x: implement TEST AND
 SET
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

On 05/29/2017 12:24 PM, Aurelien Jarno wrote:
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/insn-data.def |  3 +++
>   target/s390x/translate.c   | 10 ++++++++++
>   2 files changed, 13 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
