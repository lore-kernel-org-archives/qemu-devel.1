Received: from eggs.gnu.org ([2001:4830:134:3::10]:39683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dric8-0001US-DY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dric3-0000xX-0S
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:40:20 -0400
Date: Tue, 12 Sep 2017 12:40:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170912104005.GF29136@localhost.localdomain>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170809215510.22802-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/12] qemu-iotests: disintegrate more
 parts of common.config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 09.08.2017 um 23:55 hat Paolo Bonzini geschrieben:
> Split "check" parts from tests part.
> 
> For the directory setup, the actual computation of directories goes
> in "check", while the sanity checks go in the tests.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Same comment as for patch 1, we may want to keep this working.

Kevin
