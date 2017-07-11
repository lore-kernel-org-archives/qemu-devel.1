Received: from eggs.gnu.org ([2001:4830:134:3::10]:49995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dV52b-0001Xs-Bg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dV52a-0000hb-JN
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:58:05 -0400
Date: Wed, 12 Jul 2017 07:57:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170711235755.GA12185@lemon>
References: <149977889860.27.7155414720119907218@5d477a5b5989>
	<38be5548-0b42-59d5-b82a-733b208ced28@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38be5548-0b42-59d5-b82a-733b208ced28@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/4] Add shrink image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, den@openvz.org, armbru@redhat.com, mreitz@redhat.com

On Tue, 07/11 16:35, Pavel Butsykin wrote:
> On 11.07.2017 16:14, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed build test on s390x host. Please find the details below.
> > 
> > Type: series
> > Subject: [Qemu-devel] [PATCH v4 0/4] Add shrink image for qcow2
> > Message-id: 20170711124024.1396-1-pbutsykin@virtuozzo.com
> > 
> 
> Because this series is rebased on the pending "Implement a
> warning_report function" patch-set.
> 
> Can I exclude this check? (If I know in advance that the test will fail
> by the rebase reason)
> 

Sorry for the noise, expressing base information is till not implemented,
usually applying fails, and tests are not run. This series happens to apply
cleanly on master, but fails to build. For now, let's ignore the report. Thanks
for explaining.

Fam
