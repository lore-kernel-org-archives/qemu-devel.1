Received: from eggs.gnu.org ([209.51.188.92]:52879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h0iVx-0002Mj-0O
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h0iVw-0004zg-9p
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:59:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1h0iVw-0004xt-3L
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 02:59:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so4375375wrp.7
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 23:59:55 -0800 (PST)
Date: Mon, 4 Mar 2019 08:59:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190304075945.hx3t7ylwssnlkvad@steredhat>
References: <20190304071631.27567-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304071631.27567-1-richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/2] CODING_STYLE: trivial update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru, imammedo@redhat.com, philmd@redhat.com, eblake@redhat.com, peter.maydell@linaro.org

On Mon, Mar 04, 2019 at 03:16:29PM +0800, Wei Yang wrote:
> The first one is suggested by Igor Mammedov to provide rule for multiline
> code.
> 
> The second is a trivial fix to make example code all indented with 4 spaces.
> 
> v6:
>   * add ) for last example of function
> v5:
>   * mostly address function variants
> v4:
>   * one exception case for function
> v3:
>   * fix typo in both changelog and example
> v2:
>   * adjust Patch 1 as suggested by Eric
> 
> Wei Yang (2):
>   CODING_STYLE: specify the indent rule for multiline code
>   CODING_STYLE: indent example code as all others
> 
>  CODING_STYLE | 47 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
