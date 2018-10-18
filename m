Received: from eggs.gnu.org ([2001:4830:134:3::10]:32889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDCqC-0005Je-Fp
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDCq9-0004aY-6s
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:16:12 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35513)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gDCq8-0004WB-Ti
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:16:09 -0400
References: <20181008163521.17341-1-cst@tolva.net>
	<20181008163521.17341-4-cst@tolva.net>
	<CALQmfgO+GeBr8tE3+xzRHLe76kwKaRXC6=48s=aVtq-+dO9sxg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ca0ab844-5716-6e47-3fd3-6dcd5e9e7119@vivier.eu>
Date: Thu, 18 Oct 2018 20:15:59 +0200
MIME-Version: 1.0
In-Reply-To: <CALQmfgO+GeBr8tE3+xzRHLe76kwKaRXC6=48s=aVtq-+dO9sxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] linux-user: Implement special usbfs
 ioctls.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Cortland_Setlow_T=c3=b6lva?= <cst@tolva.net>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

Le 18/10/2018 à 18:42, Cortland Setlow Tölva a écrit :
> ping, please review v3, patch 3/3.
> 
> http://patchwork.ozlabs.org/patch/980667/

I don't have enough time to have an indeep review of this patch.
As it looks good and it's an interesting new feature, I'm going to
applied it as-is to my merge branch.

Thanks,
Laurent
