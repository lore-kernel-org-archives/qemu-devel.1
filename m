Received: from eggs.gnu.org ([2001:4830:134:3::10]:49727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1di4Rl-0001iC-Ka
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1di4Ri-0007v7-If
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:57:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1di4Ri-0007um-CD
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:57:42 -0400
Date: Wed, 16 Aug 2017 16:57:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170816195739.GL3108@localhost.localdomain>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-23-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500040339-119465-23-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 22/28] cris: replace cpu_cris_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Fri, Jul 14, 2017 at 03:52:13PM +0200, Igor Mammedov wrote:
> it's just a wrapper, drop it and use cpu_generic_init() directly
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
