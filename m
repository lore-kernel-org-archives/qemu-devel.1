Received: from eggs.gnu.org ([2001:4830:134:3::10]:52506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIXCe-0007ov-PG
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIXCa-00012C-5Z
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:24:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dIXCZ-00011y-VZ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:24:32 -0400
Date: Wed, 7 Jun 2017 17:24:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170607092426.GB4314@lemon.lan>
References: <1496820931-27416-10-git-send-email-a.perevalov@samsung.com>
	<149682484945.96.2900136396151676257@7f80c91fe18c>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149682484945.96.2900136396151676257@7f80c91fe18c>
Subject: Re: [Qemu-devel] [[PATCH V7] 09/11] migration: calculate vCPU
 blocktime on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: a.perevalov@samsung.com, dgilbert@redhat.com, peterx@redhat.com, i.maximets@samsung.com

On Wed, 06/07 01:40, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.

So what happened is the double '[[' in the subject line confused Patchew, and
each patch in this series is treated as a standalone patch.

Fam
