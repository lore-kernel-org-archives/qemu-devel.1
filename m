Received: from eggs.gnu.org ([2001:4830:134:3::10]:38057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fstra-0001RR-6A
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fstrZ-0007zL-JF
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:57:42 -0400
Date: Thu, 23 Aug 2018 14:57:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180823175723.GP3778@localhost.localdomain>
References: <20180823154655.40188-1-vsementsov@virtuozzo.com>
	<20180823154655.40188-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823154655.40188-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] scripts: add render_block_graph
 function for QEMUMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, crosa@redhat.com, den@openvz.org

On Thu, Aug 23, 2018 at 06:46:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Render block nodes graph with help of graphviz. This new function is
> for debugging, so there is no sense to put it into qemu.py as a method
> of QEMUMachine. Let's instead put it separately.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
