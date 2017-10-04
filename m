Received: from eggs.gnu.org ([2001:4830:134:3::10]:47143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzqpR-0004Qb-PF
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzqpO-0003iA-JK
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzqpO-0003gi-D4
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 17:03:38 -0400
Date: Wed, 4 Oct 2017 18:03:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171004210335.GB4015@localhost.localdomain>
References: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
	<1507111682-66171-1-git-send-email-imammedo@redhat.com>
	<1507111682-66171-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507111682-66171-3-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qom: introduce
 type_register_static_array()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Wed, Oct 04, 2017 at 12:08:01PM +0200, Igor Mammedov wrote:
> it will help to remove code duplication of registration
> static types in places that have open coded loop to
> perform batch type registering.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I will wait for 1 day or 2 before queueing it.

-- 
Eduardo
