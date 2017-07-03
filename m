Received: from eggs.gnu.org ([2001:4830:134:3::10]:46084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dS2W5-0004nr-GR
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dS2W0-0003ST-NP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:39:57 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dS2W0-0003RN-Ho
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:39:52 -0400
Received: by mail-pg0-x244.google.com with SMTP id u36so23369686pgn.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 07:39:50 -0700 (PDT)
From: Xiao Guangrong <guangrong.xiao@gmail.com>
References: <20170620091526.4287-1-xiaoguangrong@tencent.com>
Message-ID: <4dffc169-5cf2-8f37-bd99-9941bef50825@gmail.com>
Date: Mon, 3 Jul 2017 22:39:55 +0800
MIME-Version: 1.0
In-Reply-To: <20170620091526.4287-1-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] KVM: MMU: fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/20/2017 05:15 PM, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Changelog in v2:
> thanks to Paolo's review, this version disables write-protect-all if
> PML is supported

Hi Paolo,

Do you have time to have a look at this new version? ;)
Or I should wait until the patchset of dirty ring-buffer is merged?

Thanks!
