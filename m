Received: from eggs.gnu.org ([2001:4830:134:3::10]:50980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIPN-00021b-Kn
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIPJ-0001WJ-PR
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:02:21 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:36758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUIPJ-0001WA-II
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:02:17 -0400
Received: by mail-pf0-x22a.google.com with SMTP id q86so39531076pfl.3
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:02:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-7-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4b4a018a-2d0a-8488-f80c-f14f4a86e61b@twiddle.net>
Date: Sun, 9 Jul 2017 10:02:08 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-7-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/22] translate-all: make have_tb_lock
 static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:49 PM, Emilio G. Cota wrote:
> It is only used by this object, and it's not exported to any other.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   accel/tcg/translate-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
