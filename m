Received: from eggs.gnu.org ([2001:4830:134:3::10]:43100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsprakash.linux@gmail.com>) id 1d3LHz-0003Jp-Ju
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsprakash.linux@gmail.com>) id 1d3LHy-0006GB-SP
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:39:19 -0400
MIME-Version: 1.0
In-Reply-To: <1492173995-14140-2-git-send-email-eric.auger@redhat.com>
References: <1492173995-14140-1-git-send-email-eric.auger@redhat.com>
	<1492173995-14140-2-git-send-email-eric.auger@redhat.com>
From: Prakash B <bjsprakash.linux@gmail.com>
Date: Wed, 26 Apr 2017 17:09:15 +0530
Message-ID: <CACJhumf5KVCMD7jkcYBz9bFJPypbcZXoTS-TPZWD-g9z9OhQ=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC v5 1/4] linux-headers: Update for vITS
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, drjones@redhat.com, Vijay Kilari <vijay.kilari@gmail.com>, quintela@redhat.com, dgilbert@redhat.com, Vijaya.Kumar@cavium.com, Christoffer Dall <christoffer.dall@linaro.org>

On Fri, Apr 14, 2017 at 6:16 PM, Eric Auger <eric.auger@redhat.com> wrote:
> This is a linux header update against 4.11-rc6 plus the non
> upstreamed ITS migration series.
>
> https://github.com/eauger/linux/tree/v4.11-rc6-its-mig-v5
>
> It aims at enhancing the KVM user API with vITS save/restore
> capability. Those are new attributes supported in the
> ITS and GICv3 KVM device KVM_DEV_ARM_VGIC_GRP_CTRL groups.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
