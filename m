Received: from eggs.gnu.org ([2001:4830:134:3::10]:48453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJaKr-0002Dz-Nd
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJaKo-0004Fy-JU
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:25:09 -0500
References: <1478833368-25917-1-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <585A2156.6000700@cn.fujitsu.com>
Date: Wed, 21 Dec 2016 14:29:42 +0800
MIME-Version: 1.0
In-Reply-To: <1478833368-25917-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] pcie: fix typo in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, mst@redhat.com

ping

On 11/11/2016 11:02 AM, Cao jin wrote:
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  hw/pci/pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 99cfb45..39b10b8 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -656,7 +656,7 @@ static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
>  }
>  
>  /*
> - * caller must supply valid (offset, size) * such that the range shouldn't
> + * Caller must supply valid (offset, size) such that the range wouldn't
>   * overlap with other capability or other registers.
>   * This function doesn't check it.
>   */
> 

-- 
Sincerely,
Cao jin
