Received: from eggs.gnu.org ([2001:4830:134:3::10]:58926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEEfy-0007ag-Ml
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEEft-0003Ia-RL
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:21:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEEft-0003Gx-LC
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:21:17 -0500
Date: Mon, 13 Nov 2017 14:21:15 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171113132115.mymf2bparbrpxgbl@sirius.home.kraxel.org>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
	<20171112193032.9724-5-makovick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171112193032.9724-5-makovick@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 4/8] sdl2: Do not hide the cursor on
 auxilliary windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>

Fails scripts/checkpatch.pl (trailing whitespace on several lines).
