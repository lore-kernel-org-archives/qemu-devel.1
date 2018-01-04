Received: from eggs.gnu.org ([2001:4830:134:3::10]:60947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eX3Sj-0007AL-GM
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 06:13:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eX3Se-0002CY-Dv
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 06:13:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:18661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eX3Se-0002AM-5p
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 06:13:24 -0500
Message-ID: <5A4E0CDA.4060409@intel.com>
Date: Thu, 04 Jan 2018 19:15:38 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20171219162151.GA10889@stefanha-x1.localdomain>
	<1512291492.2209478.1513854089861.JavaMail.zimbra@redhat.com>
	<20180104104744.GC10106@stefanha-x1.localdomain>
In-Reply-To: <20180104104744.GC10106@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] vhost-user graceful connect/disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, =?windows-1252?Q?Marc-Andr=E9_?= =?windows-1252?Q?Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, mukawa@igel.co.jp, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, n nikolaev <n.nikolaev@virtualopensystems.com>

On 01/04/2018 06:47 PM, Stefan Hajnoczi wrote:
> On Thu, Dec 21, 2017 at 06:01:29AM -0500, Marc-André Lureau wrote:
>
> I'm not going to prototype this yet, I'm working on virtio-vhost-user
> first, but eventually I might get back to -object vhost-user(-backend).
>

Hi Stefan, are you implementing the guest slave and vhost-pci driver 
(we've posted to the dpdk mailinglist) as well? and do you have an 
estimation when would the prototype be ready?

Best,
Wei
