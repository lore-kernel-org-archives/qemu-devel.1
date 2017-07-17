Received: from eggs.gnu.org ([2001:4830:134:3::10]:43700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFqK-0006aU-8q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFqH-0004BW-63
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:54:24 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:34333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFqH-0004B2-0b
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:54:21 -0400
Received: by mail-qt0-x22f.google.com with SMTP id 32so3942352qtv.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:54:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-21-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9e1b41c5-6d9c-26d6-da87-a400ecf90269@twiddle.net>
Date: Mon, 17 Jul 2017 13:54:15 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-21-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 20/45] target/sparc: check CF_PARALLEL
 instead of parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> Thereby decoupling the resulting translated code from the current state
> of the system.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   target/sparc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
