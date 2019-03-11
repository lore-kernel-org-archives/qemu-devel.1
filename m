Received: from eggs.gnu.org ([209.51.188.92]:42515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Emy-0002Rc-0k
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Edg-0000Nx-Mp
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3Edg-0000Nd-ER
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:42:20 -0400
Date: Mon, 11 Mar 2019 07:42:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190311064218.s7gzzylbkqcfciuw@sirius.home.kraxel.org>
References: <cover.1550698466.git.DirtY.iCE.hu@gmail.com>
	<cf14255c576fd361c6cdf941f8c637e613f6cb68.1550698466.git.DirtY.iCE.hu@gmail.com>
	<63250655-a4a3-ef36-5882-65188093ff57@gmail.com>
	<20190307155643.cuypwvu7znhqng5y@sirius.home.kraxel.org>
	<80f2cc3a-2695-cd41-b379-74751c702771@gmail.com>
	<878sxpj0gx.fsf@dusky.pond.sub.org>
	<8dac1a81-bd12-322d-4cdb-badd47133cd7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dac1a81-bd12-322d-4cdb-badd47133cd7@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 04/14] audio: -audiodev command line
 option basic implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

  Hi,

> And magic errors like "'vfio-pci' is not a valid device model name"
> after update.

Try a full rebuild then.  I see strange errors now and then too, that
fixed it.  Seems the qemu build fails now and then that an object file
needs a rebuild.

cheers,
  Gerd
