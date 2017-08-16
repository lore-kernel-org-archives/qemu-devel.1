Received: from eggs.gnu.org ([2001:4830:134:3::10]:49922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1di4SQ-0002LF-2o
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1di4SP-000882-FJ
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:58:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1di4SP-00087r-91
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:58:25 -0400
Date: Wed, 16 Aug 2017 16:58:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170816195822.GO3108@localhost.localdomain>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-27-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500040339-119465-27-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 26/28] openrisc: replace
 cpu_openrisc_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stafford Horne <shorne@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Jia Liu <proljc@gmail.com>

On Fri, Jul 14, 2017 at 03:52:17PM +0200, Igor Mammedov wrote:
> it's just a wrapper, drop it and use cpu_generic_init() directly
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
