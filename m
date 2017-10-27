Received: from eggs.gnu.org ([2001:4830:134:3::10]:55446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=466efc5b4=Ian.Jackson@citrix.com>)
	id 1e81xS-0007nR-60
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=466efc5b4=Ian.Jackson@citrix.com>)
	id 1e81xP-0007aM-1u
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:33:46 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:41592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=466efc5b4=Ian.Jackson@citrix.com>)
	id 1e81xO-0007Zk-Sb
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:33:42 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23027.2948.565265.523879@mariner.uk.xensource.com>
Date: Fri, 27 Oct 2017 11:33:40 +0100
In-Reply-To: <alpine.DEB.2.10.1710261528450.3086@sstabellini-ThinkPad-X260>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<1508506702-17704-7-git-send-email-ian.jackson@eu.citrix.com>
	<alpine.DEB.2.10.1710261528450.3086@sstabellini-ThinkPad-X260>
Subject: Re: [Qemu-devel] [PATCH v5.1 7/8] os-posix: Provide new -runas
 <uid>:<gid> facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, peter.maydell@linaro.org, pbonzini@redhat.com, famz@redhat.com, kraxel@redhat.com, stefanha@redhat.com

Stefano Stabellini writes ("Re: [PATCH v5.1 7/8] os-posix: Provide new -runas <uid>:<gid> facility"):
> CC'ing the maintainers (scripts/get_maintainer.pl is your friend)

I don't know what your scripts/get_maintainer.pl does, but mine
says:

  get_maintainer.pl: No maintainers found, printing recent contributors.
  get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

  Anthony PERARD <anthony.perard@citrix.com> (commit_signer:1/2=50%)
  Paolo Bonzini <pbonzini@redhat.com> (commit_signer:1/2=50%,commit_signer:11/57=19%)
  Ian Jackson <Ian.Jackson@eu.citrix.com> (commit_signer:1/2=50%)
  Michael Tokarev <mjt@tls.msk.ru> (commit_signer:12/57=21%)
  Eric Blake <eblake@redhat.com> (commit_signer:10/57=18%)
  Thomas Huth <thuth@redhat.com> (commit_signer:8/57=14%)
  Markus Armbruster <armbru@redhat.com> (commit_signer:8/57=14%)
  qemu-devel@nongnu.org (open list:POSIX)

I have added Paolo, Markus and Daniel Berrange to the CCs of my patch
on the basis that they have commented already...

Thanks,
Ian.
