Received: from eggs.gnu.org ([2001:4830:134:3::10]:40302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cojBj-0003u7-A6
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 00:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cojBe-0005g6-AI
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 00:08:27 -0400
Date: Fri, 17 Mar 2017 12:08:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170317040817.GB13125@lemon.lan>
References: <20170317021739.16877-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317021739.16877-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Make 'replication_state' an enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On Fri, 03/17 10:17, Fam Zheng wrote:
> BDRVReplicationState.replication_state is a name with a bit of
> duplication, plus it could be an enum like BDRVReplicationState.mode,
> which is be more readable and also more straightforward in a debuuger.

s/is be/is/
s/debuuger/debugger/

Can I blame the hardware setup change I just did (further display and external
keyboard)? :-/

Fam
