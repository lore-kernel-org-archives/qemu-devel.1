Received: from eggs.gnu.org ([2001:4830:134:3::10]:35233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4az-0004lt-3x
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4au-0000Vq-Jp
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp4au-0000UU-E7
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:32:08 -0400
Date: Tue, 5 Sep 2017 11:32:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905033204.GR22515@lemon.lan>
References: <20170817035721.11064-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170817035721.11064-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Clean up paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, 08/17 11:57, Fam Zheng wrote:
> The 'run' script already creats src, build and install directories under
> $TEST_DIR, use it in common.rc.
> 
> Also the tests always run from $QEMU_SRC/tests/docker, so use a relative
> $CMD string.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Queued.

Fam
