Received: from eggs.gnu.org ([2001:4830:134:3::10]:53693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clErn-0005zN-Jc
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clErm-0007E0-MZ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:09:27 -0500
Date: Tue, 7 Mar 2017 14:09:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170307130917.GL5871@noname.str.redhat.com>
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488826849-32384-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/15] block: A bunch of fixes for
 Sheepdog and Gluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, eblake@redhat.com, f4bug@amsat.org

Am 06.03.2017 um 20:00 hat Markus Armbruster geschrieben:
> Bad error handling, memory leaks, and lack of blockdev-add support.

Thanks, applied to the block branch.

Kevin
