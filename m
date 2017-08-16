Received: from eggs.gnu.org ([2001:4830:134:3::10]:49786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1di4Ry-0001v5-EV
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1di4Rx-00081D-QF
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:57:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1di4Rx-00080z-Jo
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 15:57:57 -0400
Date: Wed, 16 Aug 2017 16:57:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170816195755.GM3108@localhost.localdomain>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-24-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500040339-119465-24-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 23/28] x86: replace cpu_x86_init() with
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Fri, Jul 14, 2017 at 03:52:14PM +0200, Igor Mammedov wrote:
> it's just a wrapper, drop it and use cpu_generic_init() directly
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
