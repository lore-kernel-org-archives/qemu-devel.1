Received: from eggs.gnu.org ([2001:4830:134:3::10]:59429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb6XO-00057d-W5
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb6XJ-0003CJ-VY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:19:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eb6XJ-0003CD-Pa
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:18:57 -0500
Date: Mon, 15 Jan 2018 16:18:53 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180115151853.iduknw4f4y26b4lt@sirius.home.kraxel.org>
References: <20171222152531.1849-1-miika9764@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171222152531.1849-1-miika9764@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] input: add keys and mouse buttons to
 virtio input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miika S <miika9764@gmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com

  Hi,

> Miika S (3):
>   input: add mouse side buttons to virtio input
>   input: virtio: don't send mouse wheel event twice

Cherry-picked these two ad the kbd update depends on the not-yet merged
keycodemapdb update for virtio-keyboard.

thanks,
  Gerd
