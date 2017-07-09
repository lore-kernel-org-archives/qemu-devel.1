Received: from eggs.gnu.org ([2001:4830:134:3::10]:57918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJ7T-0007Hb-IH
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJ7Q-0004GB-Gd
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:47:55 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUJ7Q-0004Fp-9X
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:47:52 -0400
Received: by mail-pg0-f47.google.com with SMTP id t186so39514413pgb.1
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:47:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-19-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <32125110-a6b0-e1ed-d6e8-269a267e699d@twiddle.net>
Date: Sun, 9 Jul 2017 10:46:47 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-19-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/22] tcg: define TCG_HIGHWATER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> Will come in handy very soon.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   tcg/tcg.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
