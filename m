Received: from eggs.gnu.org ([2001:4830:134:3::10]:36085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD7Iw-0008DB-JV
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD7Ir-0006E5-Ol
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:44:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD7Ir-0006Cb-Ip
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:44:37 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-23-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <98e8e059-9f27-dd12-aa79-720e879404b7@redhat.com>
Date: Tue, 23 May 2017 12:44:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-23-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/31] target/s390x: Use unwind data for
 helper_trt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 23.05.2017 05:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 9 +++++----
>  target/s390x/translate.c  | 1 -
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
