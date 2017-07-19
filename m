Received: from eggs.gnu.org ([2001:4830:134:3::10]:52841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXiCo-0003wW-Ue
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXiCo-00084m-32
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:11:30 -0400
Date: Wed, 19 Jul 2017 08:11:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170719061119.GA4617@noname.redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
	<150040425381.87.10031697933606985343@5d477a5b5989>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150040425381.87.10031697933606985343@5d477a5b5989>
Subject: Re: [Qemu-devel] [PULL 00/21] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, peter.maydell@linaro.org

Am 18.07.2017 um 20:57 hat no-reply@patchew.org geschrieben:
> **
> ERROR:/tmp/qemu-test/src/tests/test-qga.c:78:fixture_setup: assertion failed (fixture->fd != -1): (-1 != -1)
> GTester: last random seed: R02S1e410abb69660daf8fd594a35e52f43b
> make: *** [check-tests/test-qga] Error 1
> make: *** Waiting for unfinished jobs....

The patches don't touch qga and I can't reproduce the failure, so I
assume this was just intermittent failure due to a preexisting problem.

Kevin
