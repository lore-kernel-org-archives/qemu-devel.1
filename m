Received: from eggs.gnu.org ([2001:4830:134:3::10]:57445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUR5K-0000oZ-Nx
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUR5K-0003zC-0l
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:50:30 -0500
Date: Thu, 28 Dec 2017 13:50:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171228055019.GH9192@lemon>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-10-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220154945.88410-10-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v9 09/13] migration: add is_active_iterate
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, jsnow@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

On Wed, 12/20 18:49, Vladimir Sementsov-Ogievskiy wrote:
> Only-postcopy savevm states (dirty-bitmap) don't need live iteration, so
> to disable them and stop transporting empty sections there is a new
> savevm handler.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
