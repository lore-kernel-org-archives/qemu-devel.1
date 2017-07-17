Received: from eggs.gnu.org ([2001:4830:134:3::10]:40563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFk6-0003C8-5a
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFk2-00081q-AI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:47:58 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:33328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFk2-00081e-4y
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:47:54 -0400
Received: by mail-qk0-x22e.google.com with SMTP id a66so4136757qkb.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:47:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-18-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e54d6805-72e4-5fe8-f4fb-ec68b2112908@twiddle.net>
Date: Mon, 17 Jul 2017 13:47:48 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-18-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/45] target/i386: check CF_PARALLEL
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
>   target/i386/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
