Received: from eggs.gnu.org ([2001:4830:134:3::10]:48388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0TM-0003ji-9c
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0TH-0007VU-3g
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:10:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa0TG-0007UU-PV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:10:31 -0400
Date: Mon, 2 Jul 2018 17:10:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180702151027.nsio3ncp7ma6d5nq@sirius.home.kraxel.org>
References: <20180620124719.16450-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620124719.16450-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] seabios: 1.11.2 update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org, qemu-devel@nongnu.org

  Hi,

> seabios 1.11.2 is not released yet.  The plan is to cherry-pick the
> changes needed to support the new qemu 3.0 display devices
> (bochs-display and ramfb) into the 1.11-stable branch for the 1.11.2
> release.  Current state is here:
>    https://git.kraxel.org/cgit/seabios/log/?h=1.11-stable-testing

seabios release 1.11.2 tagged and pushed now.  Re-created the branch to
make sure the commit ids in the log are correct (they changed due to a
repo setup issue).  Cherry-picked one additional bugfix commit.

cheers,
  Gerd
