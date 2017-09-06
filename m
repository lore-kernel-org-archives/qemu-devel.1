Received: from eggs.gnu.org ([2001:4830:134:3::10]:58506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpZum-00072e-20
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpZui-0000qd-6j
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:58:44 -0400
Date: Wed, 6 Sep 2017 14:58:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170906125825.GH3753@dhcp-200-186.str.redhat.com>
References: <cover.1504112256.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1504112256.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/3] Live block optional
 disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, qemu-block@nongnu.org, dgilbert@redhat.com, peterx@redhat.com, mrezanin@redhat.com

Am 30.08.2017 um 19:01 hat Jeff Cody geschrieben:
> This series adds a configurable option to disable live block operations.
> 
> The default is that live block operations are 'enabled'.

Let me play dumb: Who would ever want to disable these? Is there a
legitimate reason to do this except artificially making qemu less
capable than it really is?

Kevin
