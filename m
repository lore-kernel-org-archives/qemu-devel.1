Received: from eggs.gnu.org ([2001:4830:134:3::10]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzhj-0005U4-RO
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzhf-0003hT-T6
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:49:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZzha-0003ZY-Fy
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:49:03 -0500
Date: Fri, 12 Jan 2018 14:48:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112134852.ai2ush44bvlnrb3f@sirius.home.kraxel.org>
References: <20171117112258.5888-1-makovick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117112258.5888-1-makovick@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] SDL2 various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>
Cc: qemu-devel@nongnu.org

On Fri, Nov 17, 2017 at 12:22:55PM +0100, Jindrich Makovicka wrote:
> Hi,
> 
> here is a respin of the three remaining patches, with checkpatch errors
> corrected.
> 
> Also added the Fixes: line for "sdl2 uses surface relative coordinates",
> and an explaining comment to "sdl2: Ignore UI hotkeys".

Series queued up now.

thanks,
  Gerd
