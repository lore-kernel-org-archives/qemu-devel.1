Received: from eggs.gnu.org ([2001:4830:134:3::10]:50432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6ND-0008GW-Hu
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6N9-0002fj-HQ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:45:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD6N9-0002fN-BF
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:44:59 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-11-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9fb3a1b6-9e3b-79da-7c32-6645697a8aca@redhat.com>
Date: Tue, 23 May 2017 11:44:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-11-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/31] target/s390x: Use unwind data for
 helper_clst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 23.05.2017 05:02, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 5 +++--
>  target/s390x/translate.c  | 1 -
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
