Received: from eggs.gnu.org ([2001:4830:134:3::10]:33347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1duM4j-00063g-D3
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1duM4i-00084t-LH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:12:45 -0400
Date: Tue, 19 Sep 2017 18:12:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170919171234.GA5744@stefanha-x1.localdomain>
References: <20170919155025.4098-1-stefanha@redhat.com>
	<9d3ff80c-5ae8-0fc3-6912-75c0f16f56d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d3ff80c-5ae8-0fc3-6912-75c0f16f56d2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: update
 tg->any_timer_armed[] on detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>, Max Reitz <mreitz@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On Tue, Sep 19, 2017 at 11:07:53AM -0500, Eric Blake wrote:
> On 09/19/2017 10:50 AM, Stefan Hajnoczi wrote:
> > Clear tg->any_timer_armed[] when throttling timers are destroy during
> 
> s/destroy/destroyed/

All your base are belong to us!
