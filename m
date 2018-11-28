Received: from eggs.gnu.org ([2001:4830:134:3::10]:57946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <raimue@macports.org>) id 1gS70m-0004Iw-Ow
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <raimue@macports.org>) id 1gS70l-000771-Ti
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:04:44 -0500
Received: from donkey.codingfarm.de ([2a01:4f8:190:12cf::d:1]:60176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <raimue@macports.org>) id 1gS70l-00073p-Mq
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 16:04:43 -0500
References: <20181128153526.10948-1-berrange@redhat.com>
	<165bc19e-8ed2-8979-aea7-0f6031fc6df2@redhat.com>
From: =?UTF-8?Q?Rainer_M=c3=bcller?= <raimue@macports.org>
Message-ID: <a6ad246f-b674-56d9-8c82-bb80880932a8@macports.org>
Date: Wed, 28 Nov 2018 22:04:39 +0100
MIME-Version: 1.0
In-Reply-To: <165bc19e-8ed2-8979-aea7-0f6031fc6df2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Document how to test the site
 with jekyll locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org, Yu Ning <yu.ning@intel.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 28.11.18 17:44, Paolo Bonzini wrote:
> On 28/11/18 16:35, Daniel P. Berrang=C3=A9 wrote:
>> Add a README file that tells people this is a jekyll based static
>> website, and shows people how to run jekyll for testing purposes.
>>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>
>> NB, we should really mention a license in the README too, but I don't
>> see info about what license we consider qemu-web to be covered by...

>      1	Rainer M=C3=BCller <raimue@macports.org>

> Anybody (especially non-RH people) disagrees with dual-license CC-BY-SA
> 4.0 and GPLv2+?  (So that we can copy from blog posts to manuals)?

No objections from my side.

Rainer
