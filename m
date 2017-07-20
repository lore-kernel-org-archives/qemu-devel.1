Received: from eggs.gnu.org ([2001:4830:134:3::10]:52476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY6DX-0001Ho-2T
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY6DT-0008MV-W0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:49:51 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dY6DT-0008Lo-QH
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:49:47 -0400
Received: by mail-qt0-x241.google.com with SMTP id l55so2383983qtl.3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 00:49:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-40-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <96fa098a-1bfd-8245-3e74-4a12ecd5f9ca@twiddle.net>
Date: Wed, 19 Jul 2017 21:49:41 -1000
MIME-Version: 1.0
In-Reply-To: <1500520169-23367-40-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 39/43] osdep: introduce
 qemu_mprotect_rwx/none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/19/2017 05:09 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   include/qemu/osdep.h |  2 ++
>   util/osdep.c         | 41 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 43 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
