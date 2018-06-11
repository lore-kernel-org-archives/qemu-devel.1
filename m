Received: from eggs.gnu.org ([2001:4830:134:3::10]:32966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fSCvQ-00048e-Cw
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fSCvL-0005TO-ID
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:51:20 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fSCvL-0005SV-Bc
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:51:15 -0400
Received: by mail-pf0-x242.google.com with SMTP id c22-v6so9028975pfi.2
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 19:51:14 -0700 (PDT)
References: <20180608192940.19548-1-ehabkost@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <0fd10e24-1890-e8a0-0628-df6707d0f25a@gmail.com>
Date: Mon, 11 Jun 2018 10:51:07 +0800
MIME-Version: 1.0
In-Reply-To: <20180608192940.19548-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: Remove PC_COMPAT_2_12 from 3.0
 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Babu Moger <babu.moger@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>



On 06/09/2018 03:29 AM, Eduardo Habkost wrote:
> commit f548222c added PC_COMPAT_2_12 to the 3.0 PC machine-types.
> I believe this happened during manual conflict resolution when
> applying the patch.
> 

Indeed!

Reviewed-by: Xiao Guangrong <xiaoguangrong@tencent.com>
