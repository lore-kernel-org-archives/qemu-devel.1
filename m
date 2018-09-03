Received: from eggs.gnu.org ([2001:4830:134:3::10]:47196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fwn7y-00039x-Hb
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fwn7t-0000B6-Eo
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:34:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fwn7t-00009S-82
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:34:37 -0400
Date: Mon, 3 Sep 2018 13:34:28 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180903113428.n5kueey2lyz6eftl@kamzik.brq.redhat.com>
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-4-git-send-email-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535778675-32170-4-git-send-email-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V8 3/4] tests/migration: Add migration-test
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, dgilbert@redhat.com

On Sat, Sep 01, 2018 at 01:11:14AM -0400, Wei Huang wrote:
> This patch moves the settings related migration-test from the
> migration-test.c file to a new header file.
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  tests/migration-test.c           | 28 ++++++++++++++++++----------
>  tests/migration/migration-test.h | 21 +++++++++++++++++++++
>  2 files changed, 39 insertions(+), 10 deletions(-)
>  create mode 100644 tests/migration/migration-test.h
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
