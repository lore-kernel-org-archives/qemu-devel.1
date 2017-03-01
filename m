Received: from eggs.gnu.org ([2001:4830:134:3::10]:38862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjDsm-0003cK-Ry
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 18:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjDsi-0002nC-09
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 18:42:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cjDsh-0002mi-Qg
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 18:42:03 -0500
Date: Thu, 2 Mar 2017 01:42:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170302013707-mutt-send-email-mst@kernel.org>
References: <20170301191459-mutt-send-email-mst@kernel.org>
	<4022b3c9-56c3-7cea-928c-9e0e7d070d90@linux.vnet.ibm.com>
	<20170301173823.GO10160@redhat.com>
	<20170301194704-mutt-send-email-mst@kernel.org>
	<20170301180602.GH2429@work-vm>
	<20170301200804-mutt-send-email-mst@kernel.org>
	<20170301181801.GI2429@work-vm>
	<20170301202044-mutt-send-email-mst@kernel.org>
	<302eb2e3-6fdf-9c66-91cf-f8bad469383b@linux.vnet.ibm.com>
	<20170302002303-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170302002303-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Berger <stefanb@us.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "SERBAN, CRISTINA" <cs1731@att.com>, "SHIH, CHING C" <cs1815@att.com>

On Thu, Mar 02, 2017 at 01:36:25AM +0200, Michael S. Tsirkin wrote:
> libtpms seems to be packaged and used outside QEMU, I don't say we need
> to have that in tree. I thought we were discussing swtpm cuse thing.

In any case, I'd like to stress that my comments aren't absolute.  I
merely described what would it take for me to be able to review these
patches properly but others more motivated might be able to do it with
the current cuse architecture. Should someone else review and merge
these patches, I won't comment.

-- 
MST
