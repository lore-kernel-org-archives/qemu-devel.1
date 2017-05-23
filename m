Received: from eggs.gnu.org ([2001:4830:134:3::10]:41961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD5w2-00006I-GV
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD5vz-0004Hb-AV
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:16:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD5vz-0004H0-3a
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:16:55 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-7-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b5187b9e-a213-4027-bda6-c0e4bc2829f4@redhat.com>
Date: Tue, 23 May 2017 11:16:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-7-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/31] target/s390x: Use unwind data for
 helper_mvc
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
>  target/s390x/mem_helper.c | 19 ++++++++++---------
>  target/s390x/translate.c  |  1 -
>  2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
