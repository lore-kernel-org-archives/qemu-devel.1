Received: from eggs.gnu.org ([2001:4830:134:3::10]:45057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cejDn-0002DF-8l
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cejDm-0001mh-Gv
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:09:15 -0500
Date: Fri, 17 Feb 2017 22:09:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170217140905.GB15819@lemon.lan>
References: <cover.1485365834.git.jcody@redhat.com>
	<a252efad890c55d5d59e7fe77a9a9b994ee83074.1485365834.git.jcody@redhat.com>
	<20170207101359.GD19280@lemon.lan>
	<20170217132621.GH5338@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217132621.GH5338@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/7] iscsi: Handle -iscsi user/password
 in bdrv_parse_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pbonzini@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, 02/17 14:26, Kevin Wolf wrote:
> It is the one that it put into the QDict by iscsi_parse_iscsi_option(),
> which is supposed to be the value from -iscsi.

OK! This is what I was missing. :)

Fam
