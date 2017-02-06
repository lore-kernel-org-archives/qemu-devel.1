Received: from eggs.gnu.org ([2001:4830:134:3::10]:53250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cagPK-0008RV-3q
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cagPG-0005F8-V6
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:20:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cagPG-0005F3-Q6
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:20:22 -0500
Date: Mon, 6 Feb 2017 18:20:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170206102019.GC5377@lemon.lan>
References: <20170128035929.10168-2-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170128035929.10168-2-nirsof@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] qemu-io: Add regression tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>

On Sat, 01/28 05:59, Nir Soffer wrote:
> From: Nir Soffer <nsoffer@redhat.com>
> 
> Add regression tests checking that qemu-io fail with non-zero exit code
> when reading non-existing file or using the wrong format.
> 
> Signed-off-by: Nir Soffer <nirsof@gmail.com>

This message is not correctly threaded as a reply to a v3 cover letter, and it's
hard to review. Please check your git command lines comform to the instructions
in

http://wiki.qemu-project.org/Contribute/SubmitAPatch#Submitting_your_Patches

Particularly, --cover-letter and --thread should be used in git-format-email.

Fam
