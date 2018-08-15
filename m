Received: from eggs.gnu.org ([2001:4830:134:3::10]:46432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpp0x-0004Lc-Hw
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fpp0r-0000oc-Hi
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:10:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53066 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fpp0p-0000ip-B1
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:10:33 -0400
Date: Wed, 15 Aug 2018 14:10:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180815061020.GA2708@xz-mi>
References: <20180524044454.11792-1-peterx@redhat.com>
	<87mutop3vn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mutop3vn.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v4 0/2] error-report: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Wed, Aug 15, 2018 at 07:58:52AM +0200, Markus Armbruster wrote:
> I'm afraid I let this fall through the cracks.  Sorry about that!
> 
> PATCH 2 conflicts semantically with commmit 63b88968f13: the latter adds
> a trace_vtd_err() the former doesn't replace.  Please respin.

Will do.

Regards,

-- 
Peter Xu
